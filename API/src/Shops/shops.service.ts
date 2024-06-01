import {Injectable, NotFoundException} from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Shop } from './shops.model';
import {v4 as uuidv4 } from 'uuid';

@Injectable()
export class ShopService {

    constructor(@InjectModel('Shop') private ShopModel: Model<Shop>) {}


    async insertShop(name: String, items: String) {
        const ShopId = new Date().toString();
        const newShop = new this.ShopModel({name, items,ShopId});
        const result = await newShop.save();
        console.log(result) 
        return result.id;
    }

    async getShops() {
        const Shops = await this.ShopModel.find().exec(); 
        return Shops.map(li => ({
            id: li.id,
            name: li.name,
            items: li.items,
        }));
    }
    
    async getShop(ShopId: string){
        const Shop = await this.findShop(ShopId);
        return {id: ShopId, date: Shop.name, content: Shop.items};
    }
    
    async editShop(ShopId: string, name: string, items: string) {
        const editedShop = await this.ShopModel.findByIdAndUpdate(ShopId);
        if(name) {
            editedShop.name = name;
        }
        if(items) {
            editedShop.items = items;  
        }
        editedShop.save();
        ;
    }

    private async findShop(id: string): Promise<Shop> {
        let Shop;
        try {
            Shop = await this.ShopModel.findById(id);
        }
        catch(error) {
            throw new NotFoundException('No such Shop!')
        }
        if(!Shop) {
            throw new NotFoundException('No such Shop!');
        }
        return Shop;
    }

    async deleteShop(ShopId: string) {
        await this.ShopModel.deleteOne({_id: ShopId}).exec();            
    }    
}