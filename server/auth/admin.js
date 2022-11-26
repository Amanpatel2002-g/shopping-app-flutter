const express = require('express');
const adminMiddleware = require('../middlewares/admin_middlware');
const Product = require('../models/product_model');
const adminRouter = express.Router();

adminRouter.post('/admin/add-product', adminMiddleware, async (req, res) => {
    try {
        console.log("came here");
        const { name, description, quantity, images, category, price } = req.body;
        let product = new Product({ name: name, description: description, quantity: quantity, images: images, category: category, price: price });
        product = await product.save();
        console.log(product);
        res.json(product);

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// /admin/get-product/

adminRouter.get('/admin/get-products', adminMiddleware, async (req, res)=>{
    try {
        const products = await Product.find({});
        res.json(products);
    } catch (error) {
        console.log(error.message);
        res.status(500).json({error:error.message});
    }
});


// admin-delete product

adminRouter.post('admin/delete-product', adminMiddleware, async(req, res)=>{
    try {
        const {id} = req.body;
        let product = await Product.findByIdAndDelete(id);
        product=await product.save();
        res.json(product);
    } catch (e) {
        
    }
});

module.exports=adminRouter;