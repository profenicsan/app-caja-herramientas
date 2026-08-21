import {Injectable} from '@nestjs/common';
import {DataSource} from 'typeorm';

@Injectable()
export class AppService {
  //Conexion de la base de datos directamente al servicio
  constructor(private dataSource: DataSource) {}

  async getProductores() {
    //Ejecucuion de consulta SQL para obtener todos los productores de la base de datos
    return this.dataSource.query('SELECT * FROM Productores');
  }
}