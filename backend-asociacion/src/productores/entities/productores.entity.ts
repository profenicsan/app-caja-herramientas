import {Entity, Column, PrimaryGeneratedColumn, OneToMany, CreateDateColumn} from 'typeorm';

@Entity('productores') // Asegúrate de que el nombre coincida con tu tabla en SQL
export class Productor{
    @PrimaryGeneratedColumn()
    id!: number;

    @Column({unique: true})
    cedula!: string;

    @Column()
    nombre_completo!: string;

    @Column({nullable: true})
    direccion!: string;

    @Column({nullable: true})
    telefono!: string;

    @Column()
    password_hash!: string; //Aquí se guarda el PIN encriptado

    @Column({default: 'PRODUCTOR'})
    rol!: string;

    @Column({default: true})
    debe_cambiar_password!: boolean;

    @CreateDateColumn()
    fecha_registro!: Date;
}
