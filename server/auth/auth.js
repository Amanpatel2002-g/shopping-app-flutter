const express = require('express');
const bcryptjs = require('bcryptjs');
const User = require('../models/user_model');
const jwt = require('jsonwebtoken');
const AuthMiddleware = require('../middlewares/auth_middlewares');
const authRouter = express.Router();

authRouter.post('/api/signup', async (req, res) => {
    try {
        const { name, email, password } = req.body;

        const existingUser = await User.findOne({ email: email });
        if (existingUser) {
            return res.status(401).json({ message: 'User with the same email already eixists' });
        }
        const hashedPassword = await bcryptjs.hash(password, 8);
        let user = new User({
            email,
            password: hashedPassword,
            name
        });
        user = await user.save();
        console.log(user);
        res.json(user);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

authRouter.post('/api/signin', async (req, res) => {
    try {
        const { email, password } = req.body;
        const user = await User.findOne({ email: email });
        if (!user) {
            return res.status(400).json({ message: 'User with this email does not exist' });
        }
        const isMatch = await bcryptjs.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ message: 'password does not match' });
        }
        const token = jwt.sign({ id: user._id }, "passwordKey");
        console.log(user);
        console.log({ ...user._doc, token });
        res.json({ ...user._doc, token });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

authRouter.post('/isTokenVerified', (req, res) => {
    try {
        const token = req.header('token');
        console.log(token);
        if (!token) return res.json(false);
        const isVerified = jwt.verify(token, "passwordKey");
        if (!isVerified) res.json(false);
        const userId = isVerified._id;
        const user = User.findById(userId);
        if (!user) return res.json(false);
        res.json(true);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

authRouter.get('/', AuthMiddleware, async (req, res) => {
    try {
        const userId = req.user;
        const user = await User.findById(userId);
        console.log("This get route(\) is working");
        console.log(user._doc);
        res.json({ ...user._doc, token: req.token });
    } catch (error) {
        res.json({ msg: error.message });
    }
});
module.exports = authRouter;