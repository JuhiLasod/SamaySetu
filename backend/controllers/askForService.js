const askForService=async(req,res)=>{
    try{
        const {email,datetime,place}=req.body;
        console.log(email);
        console.log(datetime);
        console.log(place);
        res.sendStatus(200);
    }
    catch(e)
    {
        res.sendStatus(500);
    }
}
export default askForService;