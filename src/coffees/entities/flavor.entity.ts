import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

@Schema()
export class Flavor extends Document {
  @Prop()
  name: string;
}

export const FlavorSchema = SchemaFactory.createForClass(Flavor);
