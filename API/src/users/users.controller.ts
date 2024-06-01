import { Controller, Body, Post, Get, Param, Put, Delete, Request, Patch, UseGuards, Req } from '@nestjs/common';
import { UsersService } from './users.service';
import { User } from './users.model';
import * as bcrypt from 'bcrypt';
import { AuthorizationGuard } from 'src/authorization/authorization.guard';
import { Role } from 'src/decorators/roles.decorator';

@Controller('user')
export class UsersController {
    constructor(private readonly usersService: UsersService) {}


    @Post('/signup')
    async createUser(
        @Body ('password') password: string,
        @Body ('username') username: string,
        @Body ('role') role: string,

    ): Promise<User> {
        const saltOrRounds = 5;
        const hashedPassword = await bcrypt.hash(password, saltOrRounds);
        const result = await this. usersService.createUser(
            username,
            hashedPassword,
            role
        );
        return result;
    }

    
    @Get(':id')
    @Role('admin')
    @UseGuards(AuthorizationGuard)
    
    async getUserById(@Param('id') userId: string) {
      return this.usersService.getUserById(userId);
    }
    
    
   
    
    // @Role('admin')
    // @UseGuards(AuthorizationGuard)
    @Patch(':id')
    async editUser(
      @Param('id') userId: string,
      @Body() updatedUser: Partial<User>,
    ) {
      return this.usersService.editUser(userId, updatedUser);
    }
    
    
    
    
    
    @Role('admin')
    @UseGuards(AuthorizationGuard)
    @Delete(':id')
    async deleteUser(@Param('id') userId: string) {
      return this.usersService.deleteUser(userId);
    }
    
    
   
    @Role('admin')
    @UseGuards(AuthorizationGuard)
    @Get()
    async getAllUsers() {
      return this.usersService.getAllUsers();
    }


    ///////
    
    
    // @Role('user')
    // @UseGuards(AuthorizationGuard)
    @Post('/list/:id')
    async createList(@Param ('id') userId, @Request() req, @Body('date') date: string, @Body('content') content: string) {
      return this.usersService.createList(userId, date, content);
    }
    
    
    @Role('user')
    @UseGuards(AuthorizationGuard)
    @Get('lists/:id')
    async getLists(@Param ('id') userId) {
      return this.usersService.getLists(userId);
    }
    
    
    // @Role('user')
    // @UseGuards(AuthorizationGuard)
    // @Get('list/:listId')
    // async getListById(@Request() request, @Param('listId') listId ) {
    //   return this.usersService.getListById(request.user.sub, listId);
    // } // returning null
    
    
    @Role('user')
    @UseGuards(AuthorizationGuard)
    @Put('/:userId/list/:listId')
    async updateList(@Param('userId') userId: string, @Param('listId') listId: string, @Body('date') date: string, @Body('content') listContent: string) {
      return this.usersService.updateList(userId, listId, date, listContent);
    }
    
    
    @Role('user')
    @UseGuards(AuthorizationGuard)
    @Delete('/:userId/list/:listId')
    async deleteList(@Param('userId') userId: string, @Param('listId') listId: string) {
      return this.usersService.deleteList(userId, listId);
    }

}
 