import { Injectable, ConflictException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import * as bcrypt from 'bcrypt';
import { Productor } from './entities/productores.entity';
import { CreateProductoresDto } from './dto/create-productores.dto';

@Injectable()
export class ProductoresService {
  constructor(
    @InjectRepository(Productor)
    private productoresRepository: Repository<Productor>,
  ) {}

  async preRegistrar(createProductoresDto: CreateProductoresDto) {
    // 1. Verificar si la cédula ya está registrada
    const existe = await this.productoresRepository.findOneBy({ cedula: createProductoresDto.cedula });
    if (existe) {
      throw new ConflictException('Ya existe un productor registrado con esta cédula');
    }

    // 2. Generar un PIN aleatorio de 4 dígitos (ej. 4829)
    const pinTemporal = Math.floor(1000 + Math.random() * 9000).toString();

    // 3. Encriptar el PIN (Hash)
    const saltRounds = 10;
    const pinHash = await bcrypt.hash(pinTemporal, saltRounds);

    // 4. Crear y guardar el nuevo productor
    const nuevoProductor = this.productoresRepository.create({
      ...createProductoresDto,
      password_hash: pinHash,
      debe_cambiar_password: true,
      rol: 'PRODUCTOR',
    });
    
    await this.productoresRepository.save(nuevoProductor);

    // 5. Retornar el resultado al panel de administración
    return {
      mensaje: 'Productor registrado con éxito',
      cedula: nuevoProductor.cedula,
      pin_generado: pinTemporal, // Única vez que se muestra sin encriptar
    };
  }
}