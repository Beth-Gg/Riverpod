import { Controller, Post, Body, Get, Param, Patch, Delete } from '@nestjs/common';
import { ListService } from './lists.service';

@Controller()

export class ListsController {
    constructor(private readonly ListsService: ListService) {}

    @Post('create')
    async createList(
        @Body('date') ListDate: string, 
        @Body('content') ListContent:string   
    ): Promise<{ id: any; }> {
        const generatedId = await this.ListsService.insertList(ListDate, ListContent);
        return {id: generatedId};
    }

    @Get('allLists')
    async getAllLists()  {  
    const Lists = await this.ListsService.getLists();
    return Lists;
    }

    @Get(':id')
    async getSingleList(@Param ('id') ListId: string) {
        const List = await this.ListsService.getList(ListId);
        return List; 
    }

    @Patch(':id') 
    async editList(@Param('id') ListId: string, 
    @Body('date') date: string, 
    @Body ('content') ListContent: string) {

        const edited = await this.ListsService.editList(ListId, date, ListContent);
        return null;
    }

    @Delete(':id')
    async deleteList(@Param('id') ListId: string) {
        await this.ListsService.deleteList(ListId);
        return null;
    }
}
