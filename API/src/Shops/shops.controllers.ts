import { Controller, Post, Body, Get, Param, Patch, Delete, Put, UseGuards } from '@nestjs/common';
import { ShopService } from './shops.service';
import { AuthorizationGuard } from 'src/authorization/authorization.guard';
import { Role } from 'src/decorators/roles.decorator';


@Controller('shop')

export class ShopsController {
    constructor(private readonly shopsService: ShopService) {}

    @Post('create')
    @Role('admin')
    @UseGuards(AuthorizationGuard)
    async createShop(
        @Body('name') shopName: string, 
        @Body('items') shopItems:string   
    ): Promise<{ id: any; }> {
        const generatedId = await this.shopsService.insertShop(shopName, shopItems);
        return {id: generatedId};
    }

    @Get('allshops')
    async getAllShops()  {  
    const shops = await this.shopsService.getShops();
    return shops;
    }

    @Get(':id')
    async getSingleShops(@Param ('id') shopId: string) {
        const shop = await this.shopsService.getShop(shopId);
        return shop; 
    }

    @Put(':id') 
    @Role('admin')
    @UseGuards(AuthorizationGuard)
    async editShop(@Param('id') shopId: string, 
    @Body('name') name: string, 
    @Body ('items') items: string) {

        const edited = await this.shopsService.editShop(shopId, name, items);
        return edited;
    }

    @Delete(':id')
    @Role('admin')
    @UseGuards(AuthorizationGuard)
    async deleteshop(@Param('id') shopId: string) {
        await this.shopsService.deleteShop(shopId);
        return null;
    }
}
