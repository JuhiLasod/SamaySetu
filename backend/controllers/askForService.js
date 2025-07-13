const askForService=async(req,res)=>{
    try{
        const {email,date,time,place}=req.body;
        console.log("reaching to backend");
        res.sendStatus(200);
    }
    catch(e)
    {
        res.sendStatus(500);
    }
}
export default askForService;