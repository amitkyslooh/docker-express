import express from "express";


const app = express();


app.get("/get-user", (req, res) => {
    const user = {
        name: "amit",
        age: 21,
        gender: "Male"
    }
    return res.json({user})
})

app.listen(process.env.PORT, () => {
    console.log(`app is working on port ${process.env.PORT}`)
})