// import express from "express";
const express = require("express");

const app = express()

app.use(express.json());
app.use(express.urlencoded({
     extended:true
}))
 const productData =[]

app.listen(30000,() => {
     console.log("Connected to server at 30000")
})


// post api request

app.post("/api/add_product",(req,res)=> {
     console.log("Result", req.body);


     const pdata = {
         "id": productData.length+1,
         "pname": req.body.pname,
         "pprice": req.body.pprice,
         "pdesc": req.body.pdesc,
     }

     productData.push(pdata);
     console.log("Final", pdata);

     res.status(200).send({
        "status_code": 200,
        "message": "Product added successfully",
        "product": pdata,
     })
},
)
// get api request
app.get("/api/get_product",(req,res)=> {
      if(productData.length >0) {
           res.status(200).send({
               'status_code': 200,
               'products': productData,
           });
      } else {
          res.status(200).send({
               'status_code': 200,
               'products': [],
           });
      }
})

// update product
app.put("/api/update/:id", (req,res)=> {
      let id = req.params.id *1;
      let productToUpdate = productData.find(p=> p.id ===id);
      let index = productData.indexOf(productToUpdate);

      productData[index] = req.body;
      res.status(200).send({
          'status': "success",
          'message': "Product updated successfully"
      })
})
// delete product
app.post("/api/delete/:id", (req,res)=> {
      let id = req.params.id *1;
      let productToUpdate = productData.find(p=> p.id ===id);
      let index = productData.indexOf(productToUpdate);

      productData.splice(index,1);

      res.status(200).send({
          'status': "success",
          'message': "Product updated successfully"
      })
})