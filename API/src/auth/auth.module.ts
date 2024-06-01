import { Module } from '@nestjs/common';
import { UsersModule } from 'src/users/users.module';
import { AuthService } from './auth.service';
import { PassportModule } from '@nestjs/passport';
import { JwtModule } from '@nestjs/jwt';
import {AuthController} from './auth.controller';
import { UsersService } from 'src/users/users.service';
import { MongooseModule } from '@nestjs/mongoose';
import { UserSchema } from 'src/users/users.model';
import { LocalStrategy } from './local.auth';
import { ListSchema } from 'src/Lists/lists.model';


@Module({
    imports: [UsersModule, PassportModule, JwtModule.register({
        secret: 'secretKey',
        signOptions: {expiresIn: '1d' },
    }), 
    MongooseModule.forFeature([
        {name: 'user', schema: UserSchema},
        {name: 'List', schema: ListSchema}

])],
    providers: [AuthService, UsersService, LocalStrategy],
    controllers: [AuthController],
})
export class AuthModule {}
