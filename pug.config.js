// Values exposed in the "locals" property will be available in the template.

module.exports = {
    locals : {
        exampleDir: process.env.EX_DIR || "example1"
    }
};
