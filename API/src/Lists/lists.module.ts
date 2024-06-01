import { Module } from "@nestjs/common";
import { ListsController } from "./lists.controllers";
import { ListService } from "./lists.service";
import { MongooseModule } from "@nestjs/mongoose";
import { ListSchema } from "./lists.model";


@Module({
    imports: [MongooseModule.forFeature([{name: 'List', schema: ListSchema }])],
    controllers: [ListsController],
    providers: [ListService],
})

export class listsModule{};