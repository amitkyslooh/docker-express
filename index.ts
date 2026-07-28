import express from "express";
import { SQL } from "bun"

const app = express();

const sql = new SQL(process.env.DATABASE_URL!)


app.get("/get-user", (req, res) => {
    const user = {
        name: "amit",
        age: 21,
        gender: "Male"
    }
    return res.json({user})
});

app.get("/db-user",  async (req, res) => {
    try {
        const user = await sql`SELECT * FROM users`;

        console.log(user);
        return res.json({user});

    } catch (err) {
        console.log("something went wrong", err)
    }
})


app.get("/health", (req, res)=> {
    return res.json({message: "good"})

})

app.get("/saymyname", (req, res) => {
    const name = req.query.yournameis;

    if(name == "amit") {
        return res.json({message: "You are good damm right"})
    }

    return res.json({message: "try again buddy"})
})

app.listen(process.env.PORT, () => {
    console.log(`app is working on port ${process.env.PORT}`)
})