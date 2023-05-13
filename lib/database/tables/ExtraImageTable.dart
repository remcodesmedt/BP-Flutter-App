class ExtraImageTable {
static const String TABLE_NAME = "extraimagetable";

static const String COLUMN_ID = "extraimageid";
static const String COLUMN_IMAGE = "extraimage";

static const String CREATE_TABLE = """
        CREATE TABLE IF NOT EXISTS $TABLE_NAME (
            $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,
            $COLUMN_IMAGE BLOB
        )
    """;

static const DROP_TABLE = "DROP TABLE IF EXISTS $TABLE_NAME";


static const COLUMNS_FOR_SELECT = [COLUMN_ID, COLUMN_IMAGE];
}