// import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
// import { Document, Types } from 'mongoose';

// export type UserDocument = User & Document;

// @Schema()

// export class User {
//     @Prop()
//     username: string;

//     @Prop()
//     password: string;

//     @Prop({default: 'user'})
//     role: string;

//     @Prop({ type: [{ type: Types.ObjectId, ref: 'List' }] })
//     List: any[any];
// }

// export const UserSchema = SchemaFactory.createForClass(User);

import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Types } from 'mongoose';
import { List, ListSchema } from '../Lists/lists.model';

export type UserDocument = User & Document;

@Schema()
export class User {
  @Prop()
  username: string;

  @Prop()
  password: string;

  @Prop({ default: 'user' })
  role: string;

  @Prop({ type: [ListSchema] })
  List: Types.DocumentArray<List>;
}

export const UserSchema = SchemaFactory.createForClass(User);
