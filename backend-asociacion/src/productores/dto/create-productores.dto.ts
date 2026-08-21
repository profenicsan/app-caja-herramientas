import { IsString, IsNotEmpty, IsOptional } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateProductoresDto {
  @ApiProperty({ example: '123456789', description: 'Documento del agricultor' })
  @IsString()
  @IsNotEmpty()
  cedula!: string;

  @ApiProperty({ example: 'Juan Agricultor', description: 'Nombre completo' })
  @IsString()
  @IsNotEmpty()
  nombre_completo!: string;

  @ApiPropertyOptional({ example: 'La Florida' })
  @IsString()
  @IsOptional()
  direccion!: string;

  @ApiPropertyOptional({ example: '3011705619' })
  @IsString()
  @IsOptional()
  telefono!: string;
}