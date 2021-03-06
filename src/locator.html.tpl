
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">

<div class="locator {{ (noGenerate.controlsOpen) ? 'controls-open' : 'controls-closed' }} {{ options.superClass }}">
  <section class="locator-display">
      <div class="locator-map-wrapper">
        <div class="locator-display-inner">
          <div class="locator-map">
            <div class="locator-map-attribution {{#options.embedAttribution}}enabled{{/}}">
              {{#options.overrideAttribution}}
                {{{ options.overrideAttribution }}}
              {{/}}
              {{^options.overrideAttribution}}
                {{{ options.tilesets[options.tileset].attribution }}}
              {{/}}
            </div>
          </div>

          <div class="locator-map-help">
            Move the marker by dragging the base.

            {{#options.drawing}}
              Use the buttons to draw shapes on the map.
            {{/drawing}}

            {{#(options.tilesets[options.tileset] && options.tilesets[options.tileset].attribution)}}
              Required attribution for this map: <br>
              <span class="attribution">{{{ options.tilesets[options.tileset].attribution }}}</span>
            {{/()}}
          </div>
      </div>
    </div>
  </section>


  <section class="locator-controls">
    <div class="minor-controls">
      <div class="toggle-controls" on-tap="toggle:'noGenerate.controlsOpen'"></div>

      <button class="minor-button minor-generate" on-tap="generate" title="Generar"><i class="fa fa-download"></i></button>
    </div>

    <div class="locator-controls-wrapper">
      <header>{{{ options.title }}}</header>

      <div class="locator-input">
        <div class="locator-history">
          <button class="small inline action undo" disabled="{{ !canUndo }}" title="Undo" on-tap="undo"><i class="fa fa-rotate-left"></i></button>
          <button class="small inline action redo" disabled="{{ !canRedo }}" title="Redo" on-tap="redo"><i class="fa fa-rotate-right"></i></button>
          <button class="small inline destructive reset" title="Eliminar todas las opciones" on-tap="resetOptions"><i class="fa fa-refresh"></i></button>
        </div>



        {{#options.geocoder}}
          <div class="config-option">
            <label>Busca un lugar introduciendo su dirección</label>
            <input type="text" placeholder="Dirección o lugar" value="{{ geocodeInput }}" lazy disabled="{{ isGeocoding }}">
          </div>
        {{/options.geocoder}}

        <!-- {{^options.geocoder}} -->
        {{^options.geocoder}}
          <div class="config-option">
            <label>Latitude and longitude location</label>

            <br><input class="coordinates" type="number" placeholder="Latitude" value="{{ options.lat }}" lazy>
            <br><input class="coordinates" type="number" placeholder="Longitude" value="{{ options.lng }}" lazy>
          </div>
          {{/options.geocoder}}
          <!-- {{/options.geocoder}} -->

        <div class="markers {{^options.markers}}no-markers{{/}}">
          <label class="no-markers-label">Marcadores</label>
          <button class="add-marker action small inline" on-tap="add-marker" title="Añadir marcador al centro del mapa"><i class="fa fa-plus"></i></button>


          <label class="markers-label">Marcadores.</label>
          <div class="help">Utiliza <code>&lt;br&gt;</code> para hacer saltos de línea.</div>

          {{#options.markers:mi}}
            <div class="marker" intro-outro="slide">
              <div class="config-option">
                <input type="text" placeholder="título del marcador" value="{{ this.text }}" lazy>
              </div>

              <div class="marker-actions">
                {{#options.markerToCenter}}
                <div class="marker-action">
                  <button class="action small" on-tap="marker-to-center:{{ mi }}" title="Mover el marcador al centro del mapa"><i class="fa fa-compass"></i></button>
                  <label class="markers-label">Mover el marcador al centro del mapa</label>
                  <button class="destructive small" on-tap="remove-marker:{{ mi }}" title="Eliminar marcador"><i class="fa fa-close"></i></button>
                </div>
                {{/}}

                {{#options.centerToMarker}}
                <div class="marker-action">
                  <button class="action small" on-tap="center-to-marker:{{ mi }}" title="Centrar el mapa al marcador"><i class="fa fa-plus-square-o"></i></button>
                  <label class="markers-label">Centrar el mapa al marcador</label>
                </div>
                {{/}}

                <div class="pickers">
                  {{#(_.size(options.markerBackgrounds) > 1)}}
                  <div class="picker">
                    <label class="markers-label">Color de fondo</label>
                    <div class="color-picker" title="Establecer el color de fondo del marcador">
                      {{#options.markerBackgrounds:bi}}
                      <!--<div class="color-picker-item {{#(options.markers[mi] && options.markers[mi].background === this)}}active{{ else }}inactive{{/()}} {{#(this.indexOf('255, 255, 255') !== -1 || this.indexOf('FFFFFF') !== -1)}}is-white{{/()}}"-->
                      <div class="color-picker-item {{#(options.markers[mi] && options.markers[mi].background === this)}}active{{ else }}inactive{{/()}} {{#(this.indexOf('255, 255, 255') !== -1 || this.indexOf('FFFFFF') !== -1)}}is-white{{/()}}"
                      style="background-color: {{ this }}"
                      on-tap="setMarker:{{ mi }},'background',{{ this }}">
                      {{/}}
                    </div>

                  </div>
                  {{/}}

                  {{#(_.size(options.markerForegrounds) > 1)}}
                  <div class="picker">
                    <label class="markers-label">Color de fuente</label>
                    <div class="color-picker" title="Establecer el color del texto del marcador">
                      {{#options.markerForegrounds:bi}}
                      <div class="color-picker-item {{#(options.markers[mi] && options.markers[mi].foreground === this)}}active{{ else }}inactive{{/()}} {{#(this.indexOf('255, 255, 255') !== -1 || this.indexOf('FFFFFF') !== -1)}}is-white{{/()}}"
                      style="background-color: {{ this }}"
                      on-tap="setMarker:{{ mi }},'foreground',{{ this }}">
                      {{/}}
                  </div>

                  </div>
                  {{/}}

                  {{#(_.size(options.markerFontSize) > 1)}}
                    <div class="picker">
                      <label class="markers-label">Tamaño de fuente</label>
                      <div class="font-picker" title="Tamaño de la fuente">
                        {{#options.markerFontSize:bi}}
                          <div class="font-picker-item {{#(options.markerFontSize[mi] && options.markerFontSize[mi].fontSize === this)}}active{{ else }}inactive{{/()}}"
                            style="color: gray"
                            on-tap="changeFontSize:{{ mi }},'foreground',{{ this }}">
                            {{ this.fontSize }}
                        {{/}}
                      </div>
                    </div>
                  {{/}}
                </div>
              </div>
            </div>
          {{/}}
        </div>

        {{#options.drawing}}
          <div class="drawing">
            <label class="markers-label">Dibuja</label>
            <div class="help">utiliza los botones del mapa para dibujar capas, polígonos, etc.</div>

            <div class="drawing-section">
              <div class="drawing-option">
                <input type="checkbox" checked="{{ options.drawingStyles.stroke }}" id="drawing-styles-stroke" lazy>
                <label for="drawing-styles-stroke">Contorno</label>
              </div>

              {{#(_.size(options.drawingStrokes) > 1 && options.drawingStyles.stroke)}}
                <div class="color-picker" title="Color del borde del dibujo">
                  {{#options.drawingStrokes:di}}
                    <div class="color-picker-item {{#(options.drawingStyles.color === this)}}active{{ else }}inactive{{/()}} {{#(this.indexOf('255, 255, 255') !== -1 || this.indexOf('FFFFFF') !== -1)}}is-white{{/()}}"
                      style="background-color: {{ this }}"
                      on-tap="setDrawing:'color',{{ this }}">
                  {{/}}
                </div>
              {{/}}
            </div>

            <div class="drawing-section">
              <div class="drawing-option">
                <input type="checkbox" checked="{{ options.drawingStyles.fill }}" id="drawing-styles-fill" lazy>
                <label for="drawing-styles-fill">Relleno</label>
              </div>

              {{#(_.size(options.drawingStrokes) > 1 && options.drawingStyles.fill)}}
                <div class="color-picker" title="Color del relleno del dibujo">
                  {{#options.drawingFills:di}}
                    <div class="color-picker-item {{#(options.drawingStyles.fillColor === this)}}active{{ else }}inactive{{/()}} {{#(this.indexOf('255, 255, 255') !== -1 || this.indexOf('FFFFFF') !== -1)}}is-white{{/()}}"
                      style="background-color: {{ this }}"
                      on-tap="setDrawing:'fillColor',{{ this }}">
                  {{/}}
                </div>
              {{/}}
            </div>
          </div>
        {{/options.drawing}}

        {{#(_.size(options.tilesets) > 1)}}
          <div class="config-option">
            <label>Tipo de mapa</label>

            <div class="image-picker images-{{ _.size(options.tilesets) }}">
              {{#options.tilesets:i}}
                <div class="image-picker-item {{ (options.tileset === i) ? 'active' : 'inactive' }}" style="background-image: url({{= preview }});" title="{{ i }}" on-tap="set:'options.tileset',{{ i }}"></div>
              {{/options.tilesets}}
            </div>
          </div>
        {{/()}}

        <!-- comment this few lines to avoid map width manipulations

        {{#(_.size(options.widths) > 1)}}
          <div class="config-option config-select">
            <label>Map width</label>

            <select value="{{ options.width }}">
              {{#options.widths:i}}
                <option value="{{ i }}">{{ i }}</option>
              {{/options.widths}}
            </select>
          </div>
        {{/()}}
    -->

        {{#(_.size(options.ratios) > 1)}}
          <div class="config-option config-select">
            <label>Ratio del mapa</label>

            <select value="{{ options.ratio }}">
              {{#options.ratios:i}}
                <option value="{{ i }}">{{ i }}</option>
              {{/options.ratios}}
            </select>
          </div>
        {{/()}}

        <div class="config-option">
          <label>Zoom del mini-mapa</label>

          <input type="range" min="-10" max="1" value="{{ options.miniZoomOffset }}" title="Ajustar el nivel de zoom">
        </div>

        <div class="config-option">
          <input type="checkbox" checked="{{ options.embedAttribution }}" id="config-embed-attribution" lazy>
          <label for="config-embed-attribution">Embed attribution</label>

          <input type="text" placeholder="Sobreescribir atribución" value="{{ options.overrideAttribution }}" lazy>
        </div>

        <div class="config-action">
          <button class="large additive generate-image" on-tap="generate">Generar imagen del mapa <i class="fa fa-download"></i></button>
        </div>

        <div class="preview">
          <h1>Preview</h1>
          <img src="" /><br>
          <a href="" class="download-link">Download</a>
        </div>
      </div>

      <footer>
        {{{ options.footer }}}
      </footer>
    </div>
  </section>
</div>
