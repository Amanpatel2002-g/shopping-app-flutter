const express = require('express');
const productRouter = express.Router();
const authMiddleware = require('../middlewares/auth_middlewares');
const Product = require('../models/product_model');
productRouter.get("/auth/products/", authMiddleware, async (req, res) => {
    try {
        console.log(req.query.category);
        const products = await Product.find({ cateogory: req.query.category })
        res.json(products);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

productRouter.get("/auth/products/search/:searchQuery", authMiddleware, async (req, res) => {
    try {
        console.log(req.params.searchQuery);
        const products = await Product.find({
            name: {
                $regex: req.params.searchQuery,
                $options: "i",
            }
        });
        res.json(products);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

productRouter.post("/auth/products/rate-product", authMiddleware, async (req, res) => {
    try {
        const { id, ratings } = req.body;
        let product = await Product.findById(id);
        for (i = 0; i < product.ratings.length; i++) {
            let p = product.ratings[i];
            if (p.userId == req.user) {
                product.ratings.splice(i, 1);
                break;
            }
        }
        const rating = { userId: req.user, ratings };
        product.ratings.push(rating);
        product = await product.save();
        res.json(product);

    } catch (err) {
        console.log({ error: err.message });
        res.status(500).json({ error: err.message });
    }

});

productRouter.get("/auth/products/deal-of-the-day", authMiddleware, async (req, res)=>{
    try {
        let products = await Product.find({});
        // A -> B 
        products = products.sort((a,b)=>{
            let aSum = 0;
            let bSum = 0;
            for(i=0; i<a.ratings.length; i++){
                aSum+=a.ratings[i].ratings;
                
            }
            for(i=0; i<b.ratings.length; i++){
                bSum+=b.ratings[i].ratings;

            }
            return aSum < bSum ?1:-1;
        });
        return res.json(products[0]);
        
    } catch (e) {
        console.log({ error: err.message });
        res.status(500).json({ error: err.message });
    }
});

module.exports = productRouter;