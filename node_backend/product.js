const mongoose = require("mongoose")

let dataSchema = new mongoose.Schema({
    'pname': {
        require: true,
        type: String,
    },
    'pprice': {
        require: true,
        type: String,
    },
    'pdesc': {
        require: true,
        type: String,
    }
})

module.exports = mongoose.model("node_js", dataSchema);