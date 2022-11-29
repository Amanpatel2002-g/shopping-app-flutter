const { Product } = require("../models/product_model");
const User = require("../models/user_model");
const express = require('express');
const AuthMiddleware = require("../middlewares/auth_middlewares");
const userRouter = express.Router();

userRouter.post("/auth/add-to-cart", AuthMiddleware, async (req, res) => {
	try {
		const { id } = req.body;
		const product = await Product.findById(id);
		let user = await User.findById(req.user);
		if (user.cart.length == 0) {
			user.cart.push({ product, quantity: 1 });
		}
		else {
			let isProductFound = false;
			for (let i = 0; i < user.cart.length; i++) {
				let productt = user.cart[i];
				if (productt.product._id.equals(product._id)) {
					isProductFound = true;
					break;
				}
			}

			if (isProductFound) {
				let producttt = user.cart.find((productt) => productt.product._id.equals(product._id));
				producttt.quantity += 1;
			}
			console.log("add-to-cart is working");

		}
		user = await user.save();
		res.json(user);
	} catch (error) {
		res.status(500).json({ err: error.message });
	}
});
userRouter.delete("/auth/reduce-quantity/:id", AuthMiddleware, async (req, res) => {
	try {
		console.log("print using delete ");
		const id = req.params.id;
		const product = await Product.findById(id);
		let user = await User.findById(req.user);
		for (let i = 0; i < user.cart.length; i++) {
			if (user.cart[i].product._id.equals(product._id)) {
				user.cart[i].quantity--;
				if (user.cart[i].quantity == 0) {
					user.cart.splice(i, 1);
				}
				break;
			}
		}

		user = await user.save();
		res.json(user);
	} catch (error) {
		console.log(error.message);
		res.status(500).json({ err: error.message });
	}
});

module.exports = userRouter;
