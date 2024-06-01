import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { JwtMiddleware } from './authorization/jwt.middleware';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { listsModule } from './Lists/lists.module';
import {MongooseModule} from '@nestjs/mongoose';
import { UsersModule } from './users/users.module';
import { AuthModule } from './auth/auth.module';
import { shopsModule } from "./Shops/shops.module";

@Module({
  imports: [listsModule, 
    AuthModule, 
    MongooseModule.forRoot('mongodb://localhost:27017/mekliye'), 
    UsersModule,
    shopsModule
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}; 
