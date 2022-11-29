const express = require('express');
const jwt = require('jsonwebtoken');
const User = require('../models/user_model');
const AuthMiddleware = async (req, res, next) => {
    try {
        console.log(req.header('token'));
        const token = req.header('token');
        if (!token) {
            return res.json({ msg: "No auth token, Access Denied!" });
        }
        const user = jwt.verify(token, "passwordKey");
        if (!user) {
            return res.status(401).json({ msg: "Token Verification failed,Access Denied!" });
        }
        req.token = token;
        req.user = user.id;
        console.log(user.id);
        console.log("Auth middleware is working\n");
        next();
    } catch (error) {
        res.status(500).json({ err: error.message });
    }
}

module.exports = AuthMiddleware;