import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Types } from 'mongoose';

export type ShopDocument = Shop & Document;

@Schema()
export class Shop {
  @Prop()
  shopId: string
  @Prop()
  name: string;

  @Prop()
  items: string;
}

export const ShopSchema = SchemaFactory.createForClass(Shop);
