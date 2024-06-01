import { Module, NestModule, MiddlewareConsumer } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import {User, UserSchema} from './users.model';
import { UsersService } from './users.service';
import { UsersController } from './users.controller';
import { List, ListSchema } from '../Lists/lists.model';
import { JwtMiddleware } from 'src/authorization/jwt.middleware';

@Module({
    imports: [MongooseModule.forFeature([
        {name: 'user', schema: UserSchema},
        {name: 'List', schema: ListSchema}
    ])],
    providers: [UsersService],
    controllers: [UsersController],
    // providers: [UsersService],
    // controllers: [UsersController]
})
export class UsersModule implements NestModule {
    configure(consumer: MiddlewareConsumer) {
      consumer.apply(JwtMiddleware).forRoutes(UsersController);
    }
  }
