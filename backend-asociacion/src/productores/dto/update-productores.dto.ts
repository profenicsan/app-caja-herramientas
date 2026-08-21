import { PartialType } from '@nestjs/mapped-types';
import { CreateProductoresDto } from './create-productores.dto';

export class UpdateProductoresDto extends PartialType(CreateProductoresDto) {}
