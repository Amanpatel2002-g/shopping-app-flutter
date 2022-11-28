const express = require("express");
const { Mongoose, default: mongoose } = require("mongoose");
const ratingSchema = require("./ratings");
const ProductSchema = mongoose.Schema({
    name:{
        type:String,
        required:true,
        trim:true
    },
    description:{
        type:String,
        required:true,
        trim:true
    },
    quantity:{
        type:Number,
        required:true
    },
    images:[
        {
            type:String,
            required:true,
        }
    ],
    category:{
        type:String,
        required:true,
    },
    price:{
        type:Number,
        required:true,
    },
    ratings:[ratingSchema],

});

const Product = mongoose.model('Product', ProductSchema);
module.exports = {Product, ProductSchema};