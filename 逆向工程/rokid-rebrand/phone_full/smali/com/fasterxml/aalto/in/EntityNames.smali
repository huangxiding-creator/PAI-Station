.class public final Lcom/fasterxml/aalto/in/EntityNames;
.super Ljava/lang/Object;
.source "EntityNames.java"


# static fields
.field public static final ENTITY_AMP:Lcom/fasterxml/aalto/in/PNameC;

.field public static final ENTITY_AMP_QUAD:I

.field public static final ENTITY_APOS:Lcom/fasterxml/aalto/in/PNameC;

.field public static final ENTITY_APOS_QUAD:I

.field public static final ENTITY_GT:Lcom/fasterxml/aalto/in/PNameC;

.field public static final ENTITY_GT_QUAD:I

.field public static final ENTITY_LT:Lcom/fasterxml/aalto/in/PNameC;

.field public static final ENTITY_LT_QUAD:I

.field public static final ENTITY_QUOT:Lcom/fasterxml/aalto/in/PNameC;

.field public static final ENTITY_QUOT_QUAD:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 20
    const-string v0, "amp"

    invoke-static {v0}, Lcom/fasterxml/aalto/in/PNameC;->construct(Ljava/lang/String;)Lcom/fasterxml/aalto/in/PNameC;

    move-result-object v0

    sput-object v0, Lcom/fasterxml/aalto/in/EntityNames;->ENTITY_AMP:Lcom/fasterxml/aalto/in/PNameC;

    .line 21
    const-string v0, "apos"

    invoke-static {v0}, Lcom/fasterxml/aalto/in/PNameC;->construct(Ljava/lang/String;)Lcom/fasterxml/aalto/in/PNameC;

    move-result-object v0

    sput-object v0, Lcom/fasterxml/aalto/in/EntityNames;->ENTITY_APOS:Lcom/fasterxml/aalto/in/PNameC;

    .line 22
    const-string v0, "gt"

    invoke-static {v0}, Lcom/fasterxml/aalto/in/PNameC;->construct(Ljava/lang/String;)Lcom/fasterxml/aalto/in/PNameC;

    move-result-object v0

    sput-object v0, Lcom/fasterxml/aalto/in/EntityNames;->ENTITY_GT:Lcom/fasterxml/aalto/in/PNameC;

    .line 23
    const-string v0, "lt"

    invoke-static {v0}, Lcom/fasterxml/aalto/in/PNameC;->construct(Ljava/lang/String;)Lcom/fasterxml/aalto/in/PNameC;

    move-result-object v0

    sput-object v0, Lcom/fasterxml/aalto/in/EntityNames;->ENTITY_LT:Lcom/fasterxml/aalto/in/PNameC;

    .line 24
    const-string v0, "quot"

    invoke-static {v0}, Lcom/fasterxml/aalto/in/PNameC;->construct(Ljava/lang/String;)Lcom/fasterxml/aalto/in/PNameC;

    move-result-object v0

    sput-object v0, Lcom/fasterxml/aalto/in/EntityNames;->ENTITY_QUOT:Lcom/fasterxml/aalto/in/PNameC;

    .line 32
    const v0, 0x616d70

    sput v0, Lcom/fasterxml/aalto/in/EntityNames;->ENTITY_AMP_QUAD:I

    .line 33
    const v0, 0x61706f73

    sput v0, Lcom/fasterxml/aalto/in/EntityNames;->ENTITY_APOS_QUAD:I

    .line 34
    const/16 v0, 0x6774

    sput v0, Lcom/fasterxml/aalto/in/EntityNames;->ENTITY_GT_QUAD:I

    .line 35
    const/16 v0, 0x6c74

    sput v0, Lcom/fasterxml/aalto/in/EntityNames;->ENTITY_LT_QUAD:I

    .line 36
    const v0, 0x71756f74

    sput v0, Lcom/fasterxml/aalto/in/EntityNames;->ENTITY_QUOT_QUAD:I

    .line 37
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 39
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
