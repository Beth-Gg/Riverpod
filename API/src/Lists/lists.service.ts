import {Injectable, NotFoundException} from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { List } from './lists.model';
import {v4 as uuidv4 } from 'uuid';

@Injectable()
export class ListService {

    constructor(@InjectModel('List') private ListModel: Model<List>) {}


    async insertList(date: String, content: String) {
        const listId = new Date().toString();
        const newList = new this.ListModel({date, content,listId});
        const result = await newList.save();
        console.log(result) 
        return result.id;
    }

    async getLists() {
        const Lists = await this.ListModel.find().exec(); 
        return Lists.map(li => ({
            id: li.id,
            date: li.date,
            content: li.content,
        }));
    }
    
    async getList(listId: string){
        const list = await this.findList(listId);
        return {id: listId, date: list.date, content: list.content};
    }
    
    async editList(listId: string, date: string, listContent: string) {
        const editedList = await this.findList(listId);
        if(date) {
            editedList.date = date;
        }
        if(listContent) {
            editedList.content = listContent;  
        }

        // editedList.save();
    }

    private async findList(id: string): Promise<List> {
        let list;
        try {
            list = await this.ListModel.findById(id);
        }
        catch(error) {
            throw new NotFoundException('No such list!')
        }
        if(!list) {
            throw new NotFoundException('No such List!');
        }
        return list;
    }

    async deleteList(listId: string) {
        await this.ListModel.deleteOne({_id: listId}).exec();            
    }    
}