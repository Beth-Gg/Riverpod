import * as mongoose from 'mongoose';

// export const ListSchema = new mongoose.Schema({
//     date: String,
//     content: String
// });

// export interface List extends mongoose.Document {
//     id: string;
//     date: string;
//     content: string;
// }

// export type ListDocument = List & Document;

// src/users/schemas/list.schema.ts

// import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
// import { Document, Types } from 'mongoose';

// export type ListDocument = List & Document;

// @Schema()
// export class List {
//   // @Prop({required: true})
//   // listId: mongoose.ObjectId
//   @Prop()
//   date: string;

//   @Prop()
//   content: string;
// }

// export const ListSchema = SchemaFactory.createForClass(List);

import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

export type ListDocument = List & Document;

@Schema()
export class List {
  @Prop()
  date: string;

  @Prop()
  content: string;
}

export const ListSchema = SchemaFactory.createForClass(List);
