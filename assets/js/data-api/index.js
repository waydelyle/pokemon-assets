class PkDataApi {
  baseUrl;

  constructor(baseUrl = "assets/data") {
    this.baseUrl = baseUrl;
  }

  /**
   * @param {string} resource
   * @returns {Promise<any>}
   */
  _getJson(resource) {
    return fetch(this.baseUrl + "/" + resource + ".json").then((res) =>
      res.json()
    );
  }

  /**
   * @returns {Promise<any>}
   */
  getPokemonList() {
    return this._getJson("pokemon");
  }

  getPokemon(name, withLearnset = false) {
    let pkm = this.getPokemonList().then((entries) => entries[name]);

    if (withLearnset) {
      pkm
        .then((entry) => {
          return Promise.all([entry, this.getLearnset(name)]);
        })
        .then((resolutions) => {
          let entry = resolutions[0];
          entry.learnset = resolutions[1];
        });
    }

    return pkm;
  }

  /**
   * @param {string} pokemonName
   * @returns {Promise<any>}
   */
  getLearnset(pokemonName) {
    return this._getJson("learnset/" + pokemonName);
  }

  /**
   * @returns {Promise<any>}
   */
  getMoves() {
    return this._getJson("moves");
  }

  /**
   * @param {string} name
   * @returns {Promise<any>}
   */
  getMove(name) {
    return this.getMoves().then((entries) => entries[name]);
  }

  /**
   * @returns {Promise<any>}
   */
  getItems() {
    return this._getJson("items");
  }

  /**
   * @param {string} name
   * @returns {Promise<any>}
   */
  getItem(name) {
    return this.getItems().then((entries) => entries[name]);
  }

  /**
   * @returns {Promise<any>}
   */
  getAbilities() {
    return this._getJson("abilities");
  }

  /**
   * @param {string} name
   * @returns {Promise<any>}
   */
  getAbility(name) {
    return this.getAbilities().then((entries) => entries[name]);
  }

  /**
   * @returns {Promise<any>}
   */
  getTypes() {
    return this._getJson("types");
  }

  /**
   * @returns {Promise<any>}
   */
  getEggGroups() {
    return this._getJson("egg-groups");
  }

  /**
   * @returns {Promise<any>}
   */
  getNatures() {
    return this._getJson("natures");
  }
}

export default PkDataApi;
