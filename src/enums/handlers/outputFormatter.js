const fs = require("fs");
const csv = require("csv-parser");

const inputFile = process.argv[2];

const enumsSchema = ["code", "key", "description"];

const dataArray = [];

fs.createReadStream(inputFile)
  .pipe(csv(enumsSchema))
  .on("data", (data) => dataArray.push(data))
  .on("end", () => {
    console.log(JSON.stringify(dataArray, null, 4));
  });
