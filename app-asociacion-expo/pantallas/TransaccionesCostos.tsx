import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, SafeAreaView, ScrollView, TextInput, Modal, Alert } from 'react-native';
import { useNavigation } from '@react-navigation/native';
import { FontAwesome5 } from '@expo/vector-icons';

import CargandoPlanta from './CargandoPlanta';

export default function TransaccionesCostos() {
  const navigation = useNavigation<any>();
  const [estaCargando, setEstaCargando] = useState(true);

  const [transacciones, setTransacciones] = useState<any[]>([
    { id: '1', tipo: 'ingreso', concepto: 'Venta de Plátano Verde', monto: 1250000, fecha: '14/09/2026' },
    { id: '2', tipo: 'egreso', concepto: 'Compra de Insumos', monto: 350000, fecha: '12/09/2026' }
  ]);

  const [modalVisible, setModalVisible] = useState(false);
  const [tipoTransaccion, setTipoTransaccion] = useState<'ingreso' | 'egreso'>('ingreso');

  // Estados para INGRESOS
  const [producto, setProducto] = useState('');
  const [tipoVenta, setTipoVenta] = useState('');
  const [cantidad, setCantidad] = useState('');
  const [precioUnitario, setPrecioUnitario] = useState('');
  const [precioEnvio, setPrecioEnvio] = useState('');

  // Estados para GASTOS
  const [categoria, setCategoria] = useState('');
  const [descripcion, setDescripcion] = useState('');
  const [importeGasto, setImporteGasto] = useState('');

  useEffect(() => {
    const temporizador = setTimeout(() => setEstaCargando(false), 1200);
    return () => clearTimeout(temporizador);
  }, []);

  const totalIngresos = transacciones.filter(t => t.tipo === 'ingreso').reduce((acc, curr) => acc + curr.monto, 0);
  const totalEgresos = transacciones.filter(t => t.tipo === 'egreso').reduce((acc, curr) => acc + curr.monto, 0);
  const balanceNeto = totalIngresos - totalEgresos;

  const formatearMoneda = (valor: number) => {
    return '$' + Math.round(valor).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
  };

  // CÁLCULO AUTOMÁTICO DEL INGRESO SEGÚN FÓRMULA DE EXCEL
  const importeCalculadoIngreso = (parseFloat(cantidad || '0') * parseFloat(precioUnitario || '0')) + parseFloat(precioEnvio || '0');

  const guardarTransaccion = () => {
    let nuevoRegistro;

    if (tipoTransaccion === 'ingreso') {
      if (!producto || !cantidad || !precioUnitario) {
        Alert.alert("Error", "Por favor completa los campos requeridos del ingreso.");
        return;
      }
      nuevoRegistro = {
        id: Date.now().toString(),
        tipo: 'ingreso',
        concepto: `Venta: ${producto} (${cantidad} unid.)`,
        monto: importeCalculadoIngreso,
        fecha: new Date().toLocaleDateString('es-CO')
      };
    } else {
      if (!categoria || !importeGasto) {
        Alert.alert("Error", "Por favor completa los campos requeridos del gasto.");
        return;
      }
      nuevoRegistro = {
        id: Date.now().toString(),
        tipo: 'egreso',
        concepto: `${categoria} - ${descripcion}`,
        monto: parseFloat(importeGasto),
        fecha: new Date().toLocaleDateString('es-CO')
      };
    }

    setTransacciones([nuevoRegistro, ...transacciones]);
    
    // Limpiar formulario
    setProducto(''); setTipoVenta(''); setCantidad(''); setPrecioUnitario(''); setPrecioEnvio('');
    setCategoria(''); setDescripcion(''); setImporteGasto('');
    setModalVisible(false);
  };

  if (estaCargando) return <CargandoPlanta mensaje="Calculando finanzas..." />;

  return (
    <SafeAreaView style={styles.contenedorPrincipal}>
      
      <View style={styles.encabezado}>
        <TouchableOpacity onPress={() => navigation.goBack()} style={styles.botonVolver}>
          <FontAwesome5 name="arrow-left" size={20} color="#00615C" />
        </TouchableOpacity>
        <Text style={styles.tituloPantalla}>Transacciones y Costos</Text>
        <View style={{ width: 20 }} />
      </View>

      <ScrollView style={styles.scrollArea} contentContainerStyle={styles.scrollContent}>
        <View style={styles.contenedorCentralizado}>
          
          <View style={styles.tableroFondo}>
            <Text style={styles.textoBalanceTitulo}>Balance Neto</Text>
            <Text style={[styles.textoBalanceMonto, { color: balanceNeto >= 0 ? '#2E7D32' : '#D32F2F' }]}>
              {formatearMoneda(balanceNeto)}
            </Text>
            <View style={styles.divisorTablero} />
            <View style={styles.filaResumen}>
              <View style={styles.columnaResumen}>
                <Text style={styles.tituloResumen}>Ingresos</Text>
                <Text style={styles.montoIngreso}>{formatearMoneda(totalIngresos)}</Text>
              </View>
              <View style={styles.columnaResumen}>
                <Text style={styles.tituloResumen}>Costos/Egresos</Text>
                <Text style={styles.montoEgreso}>{formatearMoneda(totalEgresos)}</Text>
              </View>
            </View>
          </View>

          <Text style={styles.tituloSeccion}>Historial Reciente</Text>

          {transacciones.map((t) => (
            <View key={t.id} style={styles.tarjetaTransaccion}>
              <View style={[styles.iconoTransaccion, { backgroundColor: t.tipo === 'ingreso' ? '#E8F5E9' : '#FFEBEE' }]}>
                <FontAwesome5 name={t.tipo === 'ingreso' ? 'arrow-up' : 'arrow-down'} size={16} color={t.tipo === 'ingreso' ? '#2E7D32' : '#D32F2F'} />
              </View>
              <View style={styles.infoTransaccion}>
                <Text style={styles.conceptoTransaccion}>{t.concepto}</Text>
                <Text style={styles.fechaTransaccion}>{t.fecha}</Text>
              </View>
              <Text style={[styles.montoTransaccion, { color: t.tipo === 'ingreso' ? '#2E7D32' : '#333' }]}>
                {t.tipo === 'ingreso' ? '+' : '-'}{formatearMoneda(t.monto)}
              </Text>
            </View>
          ))}

        </View>
      </ScrollView>

      <TouchableOpacity style={styles.botonFlotante} onPress={() => setModalVisible(true)}>
        <FontAwesome5 name="plus" size={24} color="#FFF" />
      </TouchableOpacity>

      <Modal visible={modalVisible} animationType="slide" transparent={true}>
        <View style={styles.modalFondo}>
          <View style={styles.modalTarjeta}>
            <Text style={styles.modalTitulo}>Nueva Transacción</Text>

            <View style={styles.selectorTipo}>
              <TouchableOpacity 
                style={[styles.botonTipo, tipoTransaccion === 'ingreso' && styles.botonTipoActivoIngreso]}
                onPress={() => setTipoTransaccion('ingreso')}
              >
                <Text style={[styles.textoBotonTipo, tipoTransaccion === 'ingreso' && {color: '#FFF'}]}>Ingreso (Venta)</Text>
              </TouchableOpacity>
              <TouchableOpacity 
                style={[styles.botonTipo, tipoTransaccion === 'egreso' && styles.botonTipoActivoEgreso]}
                onPress={() => setTipoTransaccion('egreso')}
              >
                <Text style={[styles.textoBotonTipo, tipoTransaccion === 'egreso' && {color: '#FFF'}]}>Costo/Egreso</Text>
              </TouchableOpacity>
            </View>

            <ScrollView showsVerticalScrollIndicator={false} style={{ maxHeight: 400 }}>
              
              {tipoTransaccion === 'ingreso' ? (
                <>
                  <View style={styles.filaDobleInput}>
                    <View style={{ flex: 1, marginRight: 10 }}>
                      <Text style={styles.labelFormulario}>Producto *</Text>
                      <TextInput style={styles.input} placeholder="Ej. Plátano" value={producto} onChangeText={setProducto} />
                    </View>
                    <View style={{ flex: 1 }}>
                      <Text style={styles.labelFormulario}>Tipo de Venta</Text>
                      <TextInput style={styles.input} placeholder="Ej. Mayorista" value={tipoVenta} onChangeText={setTipoVenta} />
                    </View>
                  </View>

                  <View style={styles.filaDobleInput}>
                    <View style={{ flex: 1, marginRight: 10 }}>
                      <Text style={styles.labelFormulario}>Cantidad *</Text>
                      <TextInput style={styles.input} placeholder="0" keyboardType="numeric" value={cantidad} onChangeText={setCantidad} />
                    </View>
                    <View style={{ flex: 1 }}>
                      <Text style={styles.labelFormulario}>Precio Unit. *</Text>
                      <TextInput style={styles.input} placeholder="$ 0" keyboardType="numeric" value={precioUnitario} onChangeText={setPrecioUnitario} />
                    </View>
                  </View>

                  <Text style={styles.labelFormulario}>Precio de Envío</Text>
                  <TextInput style={styles.input} placeholder="$ 0" keyboardType="numeric" value={precioEnvio} onChangeText={setPrecioEnvio} />

                  <View style={styles.contenedorTotalCalculado}>
                    <Text style={styles.textoTotalEtiqueta}>Importe Total Calculado:</Text>
                    <Text style={styles.textoTotalValor}>{formatearMoneda(importeCalculadoIngreso)}</Text>
                  </View>
                </>
              ) : (
                <>
                  <Text style={styles.labelFormulario}>Categoría de Gasto *</Text>
                  <TextInput style={styles.input} placeholder="Ej. Semillas, Transporte..." value={categoria} onChangeText={setCategoria} />

                  <Text style={styles.labelFormulario}>Descripción</Text>
                  <TextInput style={styles.input} placeholder="Detalles del gasto" value={descripcion} onChangeText={setDescripcion} />

                  <Text style={styles.labelFormulario}>Importe Total *</Text>
                  <TextInput style={styles.input} placeholder="$ 0" keyboardType="numeric" value={importeGasto} onChangeText={setImporteGasto} />
                </>
              )}

            </ScrollView>

            <View style={styles.contenedorBotonesForm}>
              <TouchableOpacity style={styles.botonCancelar} onPress={() => setModalVisible(false)}>
                <Text style={styles.textoBotonCancelar}>Cancelar</Text>
              </TouchableOpacity>
              <TouchableOpacity style={styles.botonGuardar} onPress={guardarTransaccion}>
                <Text style={styles.textoBotonGuardar}>Registrar</Text>
              </TouchableOpacity>
            </View>

          </View>
        </View>
      </Modal>

    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  contenedorPrincipal: { flex: 1, backgroundColor: '#F4F6F8' },
  encabezado: { flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between', backgroundColor: '#FFFFFF', padding: 20, shadowColor: '#000', shadowOffset: { width: 0, height: 2 }, shadowOpacity: 0.05, elevation: 3 },
  botonVolver: { padding: 5 },
  tituloPantalla: { fontSize: 20, fontWeight: 'bold', color: '#00615C' },
  scrollArea: { flex: 1 },
  scrollContent: { paddingVertical: 20 },
  contenedorCentralizado: { width: '100%', maxWidth: 700, alignSelf: 'center', paddingHorizontal: 20 },
  
  tableroFondo: { backgroundColor: '#FFFFFF', borderRadius: 16, padding: 25, marginBottom: 25, shadowColor: '#000', shadowOffset: { width: 0, height: 4 }, shadowOpacity: 0.05, shadowRadius: 10, elevation: 4 },
  textoBalanceTitulo: { fontSize: 14, color: '#666', textAlign: 'center', fontWeight: 'bold' },
  textoBalanceMonto: { fontSize: 36, fontWeight: 'bold', textAlign: 'center', marginVertical: 5 },
  divisorTablero: { height: 1, backgroundColor: '#E0E0E0', marginVertical: 20 },
  filaResumen: { flexDirection: 'row', justifyContent: 'space-between' },
  columnaResumen: { flex: 1, alignItems: 'center' },
  tituloResumen: { fontSize: 12, color: '#888', marginBottom: 5 },
  montoIngreso: { fontSize: 18, fontWeight: 'bold', color: '#2E7D32' },
  montoEgreso: { fontSize: 18, fontWeight: 'bold', color: '#D32F2F' },

  tituloSeccion: { fontSize: 18, fontWeight: 'bold', color: '#333', marginBottom: 15 },
  tarjetaTransaccion: { flexDirection: 'row', backgroundColor: '#FFF', padding: 15, borderRadius: 12, alignItems: 'center', marginBottom: 10, shadowColor: '#000', shadowOpacity: 0.03, elevation: 1 },
  iconoTransaccion: { width: 40, height: 40, borderRadius: 20, justifyContent: 'center', alignItems: 'center', marginRight: 15 },
  infoTransaccion: { flex: 1 },
  conceptoTransaccion: { fontSize: 15, fontWeight: 'bold', color: '#333' },
  fechaTransaccion: { fontSize: 12, color: '#888', marginTop: 3 },
  montoTransaccion: { fontSize: 16, fontWeight: 'bold' },
  
  botonFlotante: { position: 'absolute', bottom: 30, right: 25, width: 60, height: 60, backgroundColor: '#00615C', borderRadius: 30, justifyContent: 'center', alignItems: 'center', elevation: 5 },
  
  modalFondo: { flex: 1, backgroundColor: 'rgba(0,0,0,0.5)', justifyContent: 'flex-end' },
  modalTarjeta: { backgroundColor: '#FFF', borderTopLeftRadius: 20, borderTopRightRadius: 20, padding: 25, paddingBottom: 35 },
  modalTitulo: { fontSize: 20, fontWeight: 'bold', color: '#00615C', marginBottom: 20, textAlign: 'center' },
  selectorTipo: { flexDirection: 'row', marginBottom: 20, backgroundColor: '#F4F6F8', borderRadius: 8, padding: 4 },
  botonTipo: { flex: 1, paddingVertical: 12, alignItems: 'center', borderRadius: 6 },
  botonTipoActivoIngreso: { backgroundColor: '#2E7D32' },
  botonTipoActivoEgreso: { backgroundColor: '#D32F2F' },
  textoBotonTipo: { fontWeight: 'bold', color: '#666' },
  
  labelFormulario: { fontSize: 13, fontWeight: 'bold', color: '#333', marginBottom: 5, marginTop: 10 },
  input: { backgroundColor: '#F4F6F8', borderRadius: 8, paddingHorizontal: 15, paddingVertical: 12, fontSize: 14, color: '#333', borderWidth: 1, borderColor: '#E0E0E0' },
  filaDobleInput: { flexDirection: 'row', justifyContent: 'space-between' },
  
  contenedorTotalCalculado: { backgroundColor: '#E8F5E9', padding: 15, borderRadius: 8, marginTop: 15, flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', borderWidth: 1, borderColor: '#C8E6C9' },
  textoTotalEtiqueta: { fontSize: 14, color: '#2E7D32', fontWeight: 'bold' },
  textoTotalValor: { fontSize: 18, color: '#2E7D32', fontWeight: 'bold' },

  contenedorBotonesForm: { flexDirection: 'row', justifyContent: 'space-between', marginTop: 25 },
  botonCancelar: { flex: 1, padding: 15, borderRadius: 8, backgroundColor: '#F4F6F8', marginRight: 10, alignItems: 'center' },
  textoBotonCancelar: { color: '#666', fontWeight: 'bold' },
  botonGuardar: { flex: 1, padding: 15, borderRadius: 8, backgroundColor: '#00615C', marginLeft: 10, alignItems: 'center' },
  textoBotonGuardar: { color: '#FFF', fontWeight: 'bold' }
});