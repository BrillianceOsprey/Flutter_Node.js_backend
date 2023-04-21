// import express from "express";
const express = require("express");
const mongoose = require("mongoose");

const app = express();
const Product = require("./product");
app.use(express.json());
app.use(
    express.urlencoded({
        extended: true,
    })
);
const productData = [];

//  mongodb+srv://flutterMongoBackend:<password>@cluster1.d7ppynt.mongodb.net/?retryWrites=true&w=majority

// connect to mongoose
mongoose.set("strictQuery", false);
mongoose.connect(
    "mongodb+srv://flutterMongoBackend:flutterMongoBackend@cluster1.d7ppynt.mongodb.net/flutter",
    (error) => {
        if (!error) {
            console.log("Connceted to mongodb");

            // post api request

            app.post("/api/add_product", async (req, res) => {
                console.log("Result", req.body);

                let data = Product(req.body);
                try {
                    let dataToStore = await data.save();
                    res.status(200).json(dataToStore);
                } catch (e) {
                    res.status(400).json({
                        status: error.message,
                    });
                }
                // const pdata = {
                //     "id": productData.length+1,
                //     "pname": req.body.pname,
                //     "pprice": req.body.pprice,
                //     "pdesc": req.body.pdesc,
                // }

                // productData.push(pdata);
                // console.log("Final", pdata);

                // res.status(200).send({
                //    "status_code": 200,
                //    "message": "Product added successfully",
                //    "product": pdata,
                // })
            });
            // get api request
            app.get("/api/get_product/", async (req, res) => {
                try {
                    let data = await Product.find();
                    res.status(200).json(data);
                } catch (e) {
                    res.status(500).json(e.message
                    );
                }
                //  if(productData.length >0) {
                //       res.status(200).send({
                //           'status_code': 200,
                //           'products': productData,
                //       });
                //  } else {
                //      res.status(200).send({
                //           'status_code': 200,
                //           'products': [],
                //       });
                //  }
            });

            // update product
            app.patch("/api/update/:id", async (req, res) => {

                let id = req.params.id;
                let updatedData = req.body;
                let options = {
                    new: true
                };
                try {
                    const data = await Product.findByIdAndUpdate(id, updatedData, options);

                    res.send(data);
                } catch (error) {
                    res.send(error.message)

                }
                // let id = req.params.id * 1;
                // let productToUpdate = productData.find((p) => p.id === id);
                // let index = productData.indexOf(productToUpdate);

                // productData[index] = req.body;
                // res.status(200).send({
                //     status: "success",
                //     message: "Product updated successfully",
                // });
            });
            // delete product
            app.delete("/api/delete/:id", async (req, res) => {

                let id = req.params.id;

                try {
                    const data = await Product.findByIdAndDelete(id);
                    res.json({
                        'status': "Delete the product ${data.name} from database"
                    })
                } catch (error) {
                    res.json(error.message)

                }
                // let id = req.params.id * 1;
                // let productToUpdate = productData.find((p) => p.id === id);
                // let index = productData.indexOf(productToUpdate);

                // productData.splice(index, 1);

                // res.status(200).send({
                //     status: "success",
                //     message: "Product deleted successfully",
                // });
            });


        } else {
            console.log("Status", "Connected to mongoose");
        }
    }
),
    // start server
    app.listen(30000, () => {
        console.log("Connected to server at 30000");
    });
