// jwt.middleware.ts
import { Injectable, NestMiddleware } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';
import * as jwt from 'jsonwebtoken';
import { User } from 'src/users/users.model';

@Injectable()
export class JwtMiddleware implements NestMiddleware {
  private readonly secretKey = 'secretKey';

  use(req: Request, res: Response, next: NextFunction) {
    console.log('request header: ', req.headers)
    const token = req.headers.authorization?.split(' ')[1];
    console.log('recieved token: ', token);
    if (token) {
      try {
        const decoded = jwt.verify(token, this.secretKey) as User;
        console.log('decoded: ', decoded);

        req['user'] = decoded; // Attach user information to the request
      } catch (error) {
        console.log ('error decoding', error);
        // Handle invalid token
      }
    }
    console.log('request recieved: ', req.method, req.url);
    next();
  }
}
