import { Injectable, CanActivate, ExecutionContext, UnauthorizedException } from "@nestjs/common";
import { Observable } from "rxjs";
import { Reflector } from "@nestjs/core";
import { ROLES_KEY } from "src/decorators/roles.decorator";

@Injectable()
export class AuthorizationGuard implements CanActivate {
    constructor(private reflector: Reflector) {}

    canActivate(context: ExecutionContext): boolean | Promise<boolean> | Observable<boolean> {
        const request = context.switchToHttp().getRequest();

        // Ensure that 'user' property exists in the request
        const user = request.user;
        const requiredRole = this.reflector.getAllAndOverride(ROLES_KEY, [context.getHandler(), context.getClass()]);

        console.log('Required Role:', requiredRole);
        console.log('User Role:', user.role);
        
        if (!user || !user.role) {
            throw new UnauthorizedException('User role not found');
        }


       

        if (requiredRole !== user.role) {
            throw new UnauthorizedException('Insufficient permissions');
        }

        return true;
    }
}
