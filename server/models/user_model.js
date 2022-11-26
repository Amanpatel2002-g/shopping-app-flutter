const { default: mongoose } = require("mongoose");

const userSchema = mongoose.Schema(
    {
        name:{
            type:String,
            required:true,
            trim:true
        },
        email:{
            type:String, 
            required:true,
            trim:true,
            validator:{
                validator: (value)=>{
                    const re = /^\s*[\w\-\+_]+(\.[\w\-\+_]+)*\@[\w\-\+_]+\.[\w\-\+_]+(\.[\w\-\+_]+)*\s*$/;
                    return value.match(re);
                },
                message:"please enter the valid email property"
            }
        },
        password:{
            type:String, 
            required:true,
        },
        address:{
            type:String, 
            default:''
        },
        type:{
            type:String,
            default:'user'
        },
    }
);

const User  = mongoose.model('User', userSchema);
module.exports = User;