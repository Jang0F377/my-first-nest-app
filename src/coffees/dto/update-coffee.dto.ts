import { PartialType } from '@nestjs/swagger';
import { CreateCoffeeDto } from './create-coffee.dto';

// Use for PATCH marks all fields as optional
export class UpdateCoffeeDto extends PartialType(CreateCoffeeDto) {}
