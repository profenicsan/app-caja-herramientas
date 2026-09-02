import { IsString, IsNotEmpty } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class LoginDto {
  @ApiProperty({ example: '000000000', description: 'Cédula del usuario' })
  @IsString()
  @IsNotEmpty()
  cedula!: string;

  @ApiProperty({ example: '1234', description: 'PIN de 4 dígitos' })
  @IsString()
  @IsNotEmpty()
  pin!: string;
}