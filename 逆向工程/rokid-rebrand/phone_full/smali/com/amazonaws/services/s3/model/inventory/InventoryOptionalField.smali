.class public final enum Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;
.super Ljava/lang/Enum;
.source "InventoryOptionalField.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

.field public static final enum ETag:Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

.field public static final enum IsMultipartUploaded:Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

.field public static final enum LastModifiedDate:Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

.field public static final enum ReplicationStatus:Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

.field public static final enum Size:Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

.field public static final enum StorageClass:Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;


# instance fields
.field private final field:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 9

    .line 23
    new-instance v0, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

    const-string v1, "Size"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2, v1}, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;->Size:Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

    .line 26
    new-instance v0, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

    const-string v1, "LastModifiedDate"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2, v1}, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;->LastModifiedDate:Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

    .line 29
    new-instance v0, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

    const-string v1, "StorageClass"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2, v1}, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;->StorageClass:Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

    .line 32
    new-instance v0, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

    const-string v1, "ETag"

    const/4 v2, 0x3

    invoke-direct {v0, v1, v2, v1}, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;->ETag:Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

    .line 35
    new-instance v0, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

    const-string v1, "IsMultipartUploaded"

    const/4 v2, 0x4

    invoke-direct {v0, v1, v2, v1}, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;->IsMultipartUploaded:Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

    .line 38
    new-instance v0, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

    const-string v1, "ReplicationStatus"

    const/4 v2, 0x5

    invoke-direct {v0, v1, v2, v1}, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;->ReplicationStatus:Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

    .line 20
    sget-object v3, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;->Size:Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

    sget-object v4, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;->LastModifiedDate:Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

    sget-object v5, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;->StorageClass:Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

    sget-object v6, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;->ETag:Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

    sget-object v7, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;->IsMultipartUploaded:Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

    sget-object v8, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;->ReplicationStatus:Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

    filled-new-array/range {v3 .. v8}, [Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;->$VALUES:[Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0
    .param p3, "field"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .line 42
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 43
    iput-object p3, p0, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;->field:Ljava/lang/String;

    .line 44
    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 20
    const-class v0, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

    return-object v0
.end method

.method public static values()[Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;
    .locals 1

    .line 20
    sget-object v0, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;->$VALUES:[Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

    invoke-virtual {v0}, [Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;

    return-object v0
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 1

    .line 51
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/inventory/InventoryOptionalField;->field:Ljava/lang/String;

    return-object v0
.end method
