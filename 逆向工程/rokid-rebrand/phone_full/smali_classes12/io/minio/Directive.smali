.class public final enum Lio/minio/Directive;
.super Ljava/lang/Enum;
.source "Directive.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lio/minio/Directive;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lio/minio/Directive;

.field public static final enum COPY:Lio/minio/Directive;

.field public static final enum REPLACE:Lio/minio/Directive;


# direct methods
.method private static synthetic $values()[Lio/minio/Directive;
    .locals 2

    .line 20
    sget-object v0, Lio/minio/Directive;->COPY:Lio/minio/Directive;

    sget-object v1, Lio/minio/Directive;->REPLACE:Lio/minio/Directive;

    filled-new-array {v0, v1}, [Lio/minio/Directive;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 3

    .line 21
    new-instance v0, Lio/minio/Directive;

    const-string v1, "COPY"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lio/minio/Directive;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/minio/Directive;->COPY:Lio/minio/Directive;

    .line 22
    new-instance v0, Lio/minio/Directive;

    const-string v1, "REPLACE"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lio/minio/Directive;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/minio/Directive;->REPLACE:Lio/minio/Directive;

    .line 20
    invoke-static {}, Lio/minio/Directive;->$values()[Lio/minio/Directive;

    move-result-object v0

    sput-object v0, Lio/minio/Directive;->$VALUES:[Lio/minio/Directive;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 20
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lio/minio/Directive;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 20
    const-class v0, Lio/minio/Directive;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lio/minio/Directive;

    return-object v0
.end method

.method public static values()[Lio/minio/Directive;
    .locals 1

    .line 20
    sget-object v0, Lio/minio/Directive;->$VALUES:[Lio/minio/Directive;

    invoke-virtual {v0}, [Lio/minio/Directive;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lio/minio/Directive;

    return-object v0
.end method
