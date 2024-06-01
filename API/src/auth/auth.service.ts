import { Injectable, NotAcceptableException } from '@nestjs/common';
import { UsersService } from 'src/users/users.service';
import * as bcrypt from 'bcrypt';
import { JwtService } from '@nestjs/jwt';



@Injectable()
export class AuthService {
    constructor (private readonly userService: UsersService, private jwtService: JwtService) { }
    // async validateUser (username: string, password: string): Promise<any> {
    //     const user = await this.userService.getUser({username});
    //     if (!user) return null;
    //     const passwordValid = await bcrypt.compare(password, user.password)
    //     if(!user) {
    //         throw new NotAcceptableException('Could not find user');
    //     }
    //     if (user && passwordValid) {
    //         return user;
    //     }
    //     return null;
    // }

    // async login (user:any) {
    //     const payload = {username: user.username, sub: user._id, role: user.role};
    //     return {
    //         access_token: this.jwtService.sign(payload),

    //     };
    // }


    async login (username: string, password: string): Promise<any> {
        let user: any;
        user = await this.userService.getUser({username});
      
    
        if(!user) {
            throw new NotAcceptableException('Could not find user');
        }
        const passwordValid = await bcrypt.compare(password, user.password)
        if (user && passwordValid) {
            const payload = {username: user.username, sub: user._id, role: user.role};
            const id = user._id;
        return {
            access_token: this.jwtService.sign(payload),
            id,
        };
    }
    else{
        throw new NotAcceptableException('Could not find user');
    }

    // async login (user:any) {
    //     const payload = {username: user.username, sub: user._id, role: user.role};
    //     return {
    //         access_token: this.jwtService.sign(payload),

    //     };
    }

}
