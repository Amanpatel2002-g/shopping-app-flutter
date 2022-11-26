const Express = require('express');
const { default: mongoose } = require('mongoose');
const adminRouter = require('./auth/admin');
const authRouter = require('./auth/auth');
const productRouter = require('./product/product');
const app = Express();
const PORT = 3000;
const DB = "mongodb+srv://aman:amanpatel@cluster0.ocitnmk.mongodb.net/?retryWrites=true&w=majority";
// const DB = "mongodb+srv://amanpatel:8sNQ4JfVZR3hOYpn@cluster0.v821uli.mongodb.net/?retryWrites=true&w=majority";

app.use(Express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);

mongoose.connect(DB).then(() => {
    console.log("Database Connected");
}).catch((e) => {
    console.log({ "The error is": e });
});

app.listen(PORT, () => {
    console.log(`server running at http://localhost:${PORT}`);
});
