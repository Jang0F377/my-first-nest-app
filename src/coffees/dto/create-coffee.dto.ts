import { ApiProperty } from '@nestjs/swagger';
import { IsNumber, IsString } from 'class-validator';
import { Flavor } from '../entities/flavor.entity';

export class CreateCoffeeDto {
  @ApiProperty({ description: 'Name of the coffee' })
  @IsString()
  readonly name: string;

  @ApiProperty({ description: 'Brand of the coffee' })
  @IsString()
  readonly brand: string;

  @ApiProperty()
  @IsNumber()
  readonly recommendations: number;

  @ApiProperty()
  @IsString({ each: true })
  readonly flavors: Flavor[];
}
