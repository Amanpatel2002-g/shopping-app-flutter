const User = require('../models/user_model');
const jwt = require('jsonwebtoken');
const admin_middlware = async (req, res, next) => {
    try {
        const token = req.header('token');
        console.log(token);
        const verified = jwt.verify(token, "passwordKey");
        if (!verified) {
            return res.status(401).json({ msg: "Token Verfication failed, authentication denied" });
        }
        const user = await User.findById(verified.id);
        if (user.type != 'admin') {
            return res.status(401).json({
                msg: "you are not the admin",
            });
        }
        req.user = verified.id;
        req.token = token;
        next();
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
}

module.exports = admin_middlware; 