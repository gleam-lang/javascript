import { readdir, stat } from "fs/promises";
import { resolve, relative } from "path";

const dir = "_build/lib/gleam_javascript";

async function main() {
  console.log("Running tests...");

  let passes = 0;
  let failures = 0;

  for await (let path of await getFiles(dir)) {
    if (!path.endsWith("_test.js")) continue;
    let module = await import(path);

    for await (let fnName of Object.keys(module)) {
      if (!fnName.endsWith("_test")) continue;
      try {
        await module[fnName]();
        process.stdout.write(`\u001b[32m.\u001b[0m`);
        passes++;
      } catch (error) {
        let moduleName = "\n" + relative(dir, path).slice(0, -3);
        process.stdout.write(`\n❌ ${moduleName}.${fnName}: ${error}\n`);
        failures++;
      }
    }
  }

  console.log(`

${passes + failures} tests
${failures} failures`);
  process.exit(failures ? 1 : 0);
}

async function getFiles(dir) {
  const subdirs = await readdir(dir);
  const files = await Promise.all(
    subdirs.map(async (subdir) => {
      const res = resolve(dir, subdir);
      return (await stat(res)).isDirectory() ? getFiles(res) : res;
    })
  );
  return files.reduce((a, f) => a.concat(f), []);
}

main();
