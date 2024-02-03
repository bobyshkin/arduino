#ifndef _AIR_GRADIENT_SGP4X_H_
#define _AIR_GRADIENT_SGP4X_H_

#include "../bsp/BoardDef.h"
#include <Arduino.h>
#include <Wire.h>

class Sgp41 {
public:
  Sgp41(BoardType type);
  bool begin(TwoWire &wire);
#if defined(ESP8266)
  bool begin(TwoWire &wire, Stream &stream);
  void handle(void);
#else 
  void _handle(void);
#endif
  void end(void);
  int getTvocIndex(void);
  int getNoxIndex(void);

private:
  bool onConditioning = true;
  bool ready = false;
  bool _isInit = false;
  void *_sensor;
  void *_vocAlgorithm;
  void *_noxAlgorithm;
  const BoardDef *bsp = nullptr;
  BoardType _boardType;
  uint16_t defaultRh = 0x8000;
  uint16_t defaultT = 0x6666;
  int tvoc = 0;
  int nox = 0;
#if defined(ESP8266)
  uint32_t conditioningPeriod;
  uint8_t conditioningCount;
  Stream *_debugStream = nullptr;
  const char *TAG = "SGP4x";
#else
  TaskHandle_t pollTask;
#endif
  bool checkInit(void);
  bool boardSupported(void);
  int sdaPin(void);
  int sclPin(void);
  bool getRawSignal(uint16_t &raw_voc, uint16_t &raw_nox,
                    uint16_t defaultRh = 0x8000, uint16_t defaultT = 0x6666);
  bool turnHeaterOff(void);
  bool getSerialNumber(uint16_t serialNumbers[], uint8_t serialNumberSize);
  bool _noxConditioning(void);
};

#endif /** _AIR_GRADIENT_SGP4X_H_ */