// import { Module } from "@nestjs/common";
import { ShopsController } from "./shops.controllers";
import { ShopService } from "./shops.service";
import { MongooseModule } from "@nestjs/mongoose";
import { ShopSchema } from "./shops.model";
// import { ShopModel } from "./shops.model";
import { JwtMiddleware } from 'src/authorization/jwt.middleware';
import { Module, NestModule, MiddlewareConsumer } from '@nestjs/common';



@Module({
    imports: [MongooseModule.forFeature([{name: 'Shop', schema: ShopSchema }])],
    controllers: [ShopsController],
    providers: [ShopService],
})

export class shopsModule implements NestModule {
    configure(consumer: MiddlewareConsumer) {
      consumer.apply(JwtMiddleware).forRoutes(ShopsController);
    }
  }
