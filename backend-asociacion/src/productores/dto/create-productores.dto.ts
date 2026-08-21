import {IsString, IsNotEmpty, IsOptional} from 'class-validator';

export class CreateProductoresDto {
    @IsString()
    @IsNotEmpty()
    cedula!: string;

    @IsString()
    @IsNotEmpty()
    nombre_completo!: string;

    @IsString()
    @IsOptional()
    direccion!: string;

    @IsString()
    @IsOptional()
    telefono!: string;

    @IsString()
    @IsNotEmpty()
    password_hash!: string;
}