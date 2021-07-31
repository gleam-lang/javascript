import { readdir } from "fs/promises";
import { resolve, relative, basename } from "path";

const dir = "node_modules/gleam_javascript";

async function getFiles(dir) {
  const dirents = await readdir(dir, { withFileTypes: true });
  const files = await Promise.all(
    dirents.map((dirent) => {
      const res = resolve(dir, dirent.name);
      return dirent.isDirectory() ? getFiles(res) : res;
    })
  );
  return Array.prototype.concat(...files);
}

async function main() {
  console.log("Running tests...");

  let passes = 0;
  let failures = 0;

  for (let path of await getFiles(dir)) {
    if (!path.endsWith("_test.js")) continue;
    process.stdout.write("\n" + relative(dir, path).slice(0, -3) + ":\n  ");
    let module = await import(path);
    for (let fnName of Object.keys(module)) {
      if (!fnName.endsWith("_test")) continue;
      try {
        module[fnName]();
        process.stdout.write("✨");
        passes++;
      } catch (error) {
        process.stdout.write(`❌ ${fnName}: ${error}\n  `);
        failures++;
      }
    }
  }

  console.log(`

${passes + failures} tests
${passes} passes
${failures} failures`);
  process.exit(failures ? 1 : 0);
}

main();
