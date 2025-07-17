import mongoose from 'mongoose';

const requestsSchema=new mongoose.Schema({
    from: {type:String},
    to: {type:String},
    service:{type:String}, 
    datetime: {type: String},
    place:{type:String},
    status: {type: String, default:'Pending'}
})
export default mongoose.model('Requests',requestsSchema);